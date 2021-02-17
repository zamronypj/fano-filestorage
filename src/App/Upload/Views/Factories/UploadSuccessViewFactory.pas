(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit UploadViewFactory;

interface

{$MODE OBJFPC}
{$H+}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for view TUploadView
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TUploadSuccessViewFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    SysUtils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    UploadView;

    function TUploadSuccessViewFactory.build(const container : IDependencyContainer) : IDependency;
    var freader : IFileReader;
    begin
        freader := container['fileReader'] as IFileReader;
        result := TUploadView.create(
            container['baseTemplate'] as IView,
            container['templateParser'] as ITemplateParser,
            freader.readFile('../resources/Templates/uploadsuccess.tpl.html')
        );
    end;
end.
