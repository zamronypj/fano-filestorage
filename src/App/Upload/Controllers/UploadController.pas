(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit UploadController;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /upload
     *
     * See Routes/Upload/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TUploadController = class(TAbstractController)
    private
        fUploadFormView : IView;
        fSuccessView : IView;
        fViewParams : IViewParameters;
        fFileStorage : IFileStorage;
        fValidator : IRequestValidator;

        function showUploadForm(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse;

        function handleUpload(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse;


    public
        constructor create(
            const uploadFormViewInst : IView;
            const successViewInst : IView;
            const viewParamsInst : IViewParameters;
            const validator : IRequestValidator;
            const storage : IFileStorage
        );

        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;
    end;

implementation

    constructor TUploadController.create(
        const uploadFormViewInst : IView;
        const successViewInst : IView;
        const viewParamsInst : IViewParameters;
        const validator : IRequestValidator;
        const storage : IFileStorage
    );
    begin
        fUploadFormView := uploadFormViewInst;
        fSuccessView := successViewInst;
        fViewParams := viewParamsInst;
        fFileStorage := storage;
        fValidator := validator;
    end;

    function TUploadController.showUploadForm(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    begin
        result := fView.render(fViewParams, response);
    end;

    function TUploadController.handleUpload(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    var uploadedFile : IFileUploadedArray;
        validationRes : TValidationResult;
    begin
        validationRes := fValidator.validate(request);
        if validationRes.isValid then
        begin
            uploadedFile := request.getUploadedFile('photo');
            fFileStorage.put('storage/upload', uploadedFile);
            result := fSuccessView.render(fViewParams, response);
        end else
        begin
            fViewParams['error'] := validationRes.errorMessages[0];
            result:= showUploadForm(request, response, args);
        end;
    end;

    function TUploadController.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    begin
        if (request.method = 'POST') then
        begin
            result := handleUpload(request, response, args);
        end else
        begin
            result := showUploadForm(request, response, args);
        end;
    end;

end.
