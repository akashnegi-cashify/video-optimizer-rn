// Jest mock for react-native-fs. Same rationale as ffmpeg-kit-react-native mock.

const RNFS = {
  CachesDirectoryPath: '/tmp/mock-cache',
  TemporaryDirectoryPath: '/tmp/mock-tmp',
  DocumentDirectoryPath: '/tmp/mock-docs',
  stat: jest.fn(),
  unlink: jest.fn(),
  exists: jest.fn(),
};

export default RNFS;
