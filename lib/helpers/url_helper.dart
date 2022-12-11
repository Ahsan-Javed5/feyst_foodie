class ExtoURLHelpers {
  static String getRestApiURL(String url) {
    final parts = url.toString().split('//');
    return [parts.first, ''].join('//') + parts.last;
  }

  static String getLegacyApiURLWithVersion(String url) {
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    return url + '/api/v1';
  }
}
