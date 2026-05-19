// =============================================================================
// MIGRATION NOTE (RN host + Flutter guest):
// The combined build now uses ./scripts/build.sh as the single entrypoint.
// The existing FlutterBuilder pipeline below still works for pure-Flutter
// builds against the legacy android_flutter_backup/ios_flutter_backup paths,
// but RN-host builds must use scripts/build.sh.
//
// To switch this Jenkins job to the RN-host pipeline:
//   sh "FLAVOR=${params.FLAVOR} PLATFORM=${params.PLATFORM} ./scripts/build.sh"
//
// See docs/DEVELOPER_WORKFLOW.md section 9 for the full migration steps.
// =============================================================================

@Library('jenkins-build-pipeline')
import in.cashify.build.FlutterBuilder

def builder = new FlutterBuilder(this, [slackChannels: '#console-flutter', 'outlineCollectionId':'c402865e-4f0d-46d1-a718-399e1f80e715'])
def params = [
        choice(choices: ['stage', 'beta', 'prod', 'Runner'], description: 'Deployment Environment', name: 'FLAVOR'),
        choice(choices: ['android', 'ios', 'web'], description: 'Platform name Environment', name: 'PLATFORM'),
        choice(choices: ['aab', 'apk'], description: 'Android build type', name: 'EXPORT_TYPE'),
        string(defaultValue: '10', description: 'Minimum code coverage threshold (%)', name: 'MIN_COVERAGE')
]
jenkinsBuildPipeline(builder, params)
