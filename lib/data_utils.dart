abstract class DataUtils {
  static String getUserImage(String username) {
    if (username == 'effrenanthony') {
      return 'https://firebasestorage.googleapis.com/v0/b/quick-id-9087a.appspot.com/o/upload%2Fimage_picker_4CDA74F7-CBFE-4298-B279-60C229B9E8D3-7762-0000046191B1E43F.jpg?alt=media&token=b4095abd-96ed-4658-ae8a-170a8bf9efc9';
    }
    return _getImageUrl(username);
  }

  static String getChannelImage() => _getImageUrl('');

  static String _getImageUrl(String value) =>
      'https://ui-avatars.com/api/?name=${value}&background=random';
}
