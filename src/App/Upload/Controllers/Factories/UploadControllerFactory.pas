(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit UploadControllerFactory;

interface

{$MODE OBJFPC}
{$H+}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller TUploadController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TUploadControllerFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    UploadController;

    function TUploadControllerFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        //build your controller instance here.
        //container will gives you access to all registered services
        result := TUploadController.create(
            container['uploadView'] as IView,
            container['viewParams'] as IViewParameters,
            container['validator'] as IRequestValidator,
            container['storage'] as IFileStorage
        );
    end;
end.
