
// Application variables
const String appVarEnvironment = String.fromEnvironment(
  'APPLICATION_ENVIRONMENT',
  defaultValue: 'release',
);
const String appVarLogLevel = String.fromEnvironment(
  'APPLICATION_LOG_LEVEL',
  defaultValue: 'error',
);
const String companyName = String.fromEnvironment(
  'COMPANY_NAME',
  defaultValue: 'failboat',
);