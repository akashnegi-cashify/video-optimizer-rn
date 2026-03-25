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
