(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

{%dependencies.inc}

{---put your views-related dependencies registration here---}

container.add('templateParser', TTemplateParserFactory.create());
container.add('fileReader', TStringFileReaderFactory.create());
container.add('baseTemplate', TBaseViewFactory.create());
container.add('uploadView', TUploadViewFactory.create());
container.add('uploadSuccessView', TUploadSuccessViewFactory.create());
