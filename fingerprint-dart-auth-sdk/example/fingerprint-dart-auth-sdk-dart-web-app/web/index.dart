import 'dart:html';

void main() {
  querySelector('#btn-sdk-setup')?.onClick.listen((_) {
    // Redirect to SDK Setup & Initialization screen
    window.location.href = "sdk_setup.html";
  });
}
