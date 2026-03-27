/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.WebView 1.0
import Sailfish.WebEngine 1.0
import Sailfish.WebView.Popups 1.0
import Nemo.Configuration 1.0
import Nemo.KeepAlive 1.2
import io.thp.pyotherside 1.5

//WebViewPage {
Page {
     id: idPage
//    DisplayBlanking { preventBlanking: true }

    function refresh() {
        webView.reload()
    }

    SilicaFlickable {
        id:main
        visible: true
        anchors.fill: parent
        clip: true;
        contentHeight: parole.height
        contentWidth: parent.width

        PullDownMenu {
            MenuItem {
                text: "Refresh"
                onClicked: {
                    refresh()
                }
             }
        }

        WebView {
            id: webView
            DisplayBlanking { preventBlanking: true }
            KeepAlive { enabled: true }
                anchors.fill: parent
                url: "http://" + dnsAddress
                privateMode : true

            popupProvider: PopupProvider {
                // Disable the Save Password dialog
                passwordManagerPopup: null
            }
        }
    }
            Python {
                id: python
                Component.onCompleted: {
                    addImportPath(Qt.resolvedUrl('../../src'));
                    importModule('readdns', function () {
                        call('readdns.connmandns', [], function (result) {
//                            console.log('IP: ' + result);
                            dnsAddress = result
                        });
                    });
                }
            }
}