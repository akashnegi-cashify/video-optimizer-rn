@Library('jenkins-build-pipeline@dev')
import in.cashify.build.FlutterBuilder

def builder = new FlutterBuilder(this, [slackChannels: '#console-flutter'])
def params = [
        choice(choices: ['stage', 'beta', 'prod'], description: 'Deployment Environment', name: 'FLAVOR'),
        choice(choices: ['android', 'ios', 'web'], description: 'Platform name Environment', name: 'PLATFORM'),
        choice(choices: ['aab', 'apk'], description: 'Android build type', name: 'EXPORT_TYPE')
]
jenkinsBuildPipeline(builder, params)