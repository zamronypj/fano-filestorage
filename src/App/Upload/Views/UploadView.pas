(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit UploadView;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * View instance
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TUploadView = class(TInjectableObject, IView)
    private
        fBaseTemplate : IView;
        fTemplateParser : ITemplateParser;
        fMainContent : string;
    public
        constructor create(
            const baseTemplate : IView;
            const templateParser : ITemplateParser;
            const mainContent : string
        );

        (*!------------------------------------------------
         * render view
         *------------------------------------------------
         * @param viewParams view parameters
         * @param response response instance
         * @return response
         *-----------------------------------------------*)
        function render(
            const viewParams : IViewParameters;
            const response : IResponse
        ) : IResponse;
    end;

implementation

    constructor TUploadView.create(
        const baseTemplate : IView;
        const templateParser : ITemplateParser;
        const mainContent : string
    );
    begin
        fBaseTemplate := baseTemplate;
        fTemplateParser := templateParser;
        fMainContent := mainContent;
    end;

    (*!------------------------------------------------
     * render view
     *------------------------------------------------
     * @param viewParams view parameters
     * @param response response instance
     * @return response
     *-----------------------------------------------*)
    function TUploadView.render(
        const viewParams : IViewParameters;
        const response : IResponse
    ) : IResponse;
    begin
        viewParams['content'] := fTemplateParser.parse(fMainContent, viewParams);
        result := fBaseTemplate.render(viewParams, response);
    end;

end.
