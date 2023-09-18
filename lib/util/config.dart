
// Application variables
const appVarEnvironment = String.fromEnvironment(
  'APPLICATION_ENVIRONMENT',
  defaultValue: 'release',
);
const appVarLogLevel = String.fromEnvironment(
  'APPLICATION_LOG_LEVEL',
  defaultValue: 'error',
);
const companyName = String.fromEnvironment(
  'COMPANY_NAME',
  defaultValue: 'failboat',
);