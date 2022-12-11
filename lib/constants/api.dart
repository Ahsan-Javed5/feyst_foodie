abstract class Api {
  static const connectionTimeout = 30000;

  // header keys
  static const headerContentTypeKey = 'Content-Type';
  static const headerContentTypeValue = 'application/json';
  static const headerTokenKey = 'token';
  static const headerUserKey = 'c_userid';
  static const headerAuthKey = 'authorization';
  static const headerTenantKey = 'X-TENANT-ID';
  static const headerProjectKey = 'X-PROJECT-ID';
  static const headerWorkspaceKey = 'X-WORKSPACE-ID';

  static const defaultHedears = {headerContentTypeKey: headerContentTypeValue};
  static const authBearer = 'Bearer ';

  //Upload request form data keys
  static const uploadModule = 'module';
  static const uploadLinkedID = 'linkedID';
  static const uploadLinkedRefID = 'linkedRefID';
  static const uploadFile = 'file';
  static const uploadParentID = 'parentID';
  static const uploadParentId = 'parentId';
  static const uploadMeta = 'meta';

  //base URLs
  static const apiVersion = 'api/v1';
  static const apiVersion2 = 'node/api/v2';
  static const client = 'client/';
  static const rest = 'rest/';
  static const baseURL = 'https://weburl.com/client/';
  static const devBaseURL = 'https://abc2.com/';
  static const dprBaseURL = 'https://abc.com/';

  //screen endpoints
  static const login = 'api/auth/login';
  static const logout = 'logout';
  static const accessToken = 'api/auth/access-token';
  static const refreshToken = '$apiVersion/refresh-token';
  static const customers = '$apiVersion/customer';
  static const workspaces = '$apiVersion/workspace';
  static const projectList = '$apiVersion/project';
  static const projectDetails = '$projectList/%s';
  static const moduleList = '$apiVersion/module';
  static const customFormList = '$apiVersion/form';
  static const records = '$apiVersion/module-record';

  static const moduleSubMenuList = '$apiVersion2/menu/project/';

  static const subMenuList = '$apiVersion/module';

  // workflow endpoints
  static const workflowTemplate = '$apiVersion/workflow-template';
  static const workflowAction = '$apiVersion/workflow';
  static const workflowActionApprove = '$workflowAction/approve';
  static const workflowActionReject = '$workflowAction/reject';
  static const workflowActionReturn = '$workflowAction/return';
  static const workflowActionWithdraw = '$workflowAction/withdraw';
  static const workflowActionRevoke = '$workflowAction/revoke';
  static const workflowActionInitiate = '$workflowAction/initiate';
  static const apiDatasets = '/data-set/';
  static const apiForms = '/form';
  static const apiDashboards = '/dashboard/';
  static const permission = '/permission';

  static const checkListById = '/checklistmaster';

  static const externalFields = '$apiVersion/external-fields';

  static const referenceTable = '$apiVersion/reference-table';

  // Workflow v3 api's endpoints
  static const moduleRecords = 'api/v3/module-record';
  static const templateId = '?templateId=';
  static const workflowByModuleId = 'api/v3/workflow-template/by-module-id/';
  static const workflowCanCreatePermission =
      'api/v3/workflow-permission/can-create/by-module/';
  static const workflowCanSubmitPermission =
      'api/v3/workflow-permission/can-submit/by-workflow-template/';
  static const createWorkflow = 'api/v3/workflow/create';
  static const submitWorkflow = 'api/v3/workflow/submit';
  static const saveAsDraft = '$apiVersion/generic/shared-draft';

  ///can create
  static const wfTempCurrentStep = '/api/v3/workflow-template/%s/current-step';

  ///can submit
  static const wfCurrentStep = '/api/v3/workflow/%s/current-step';

  // Error Messages:
  static const noConnection = 'No Internet connection';
  static const connectionFailurePrefixMessage =
      'Error occured while Communication with Server with StatusCode : ';
  static const invalidRequest = 'Invalid Request: ';
  static const unauthorizedRequest = 'Unauthorized: ';
  static const requiredField = 'Required Field';
  static const communicationError = 'Error During Communication: ';
  static const customerToken = '$apiVersion/customers/%s/refresh';

  static const apiDocuments = '/document';
  static const apiDocumentsUploadSwitch = '/upload';
  static const apiDocumentsDownloadSwitch = '/download';
}
