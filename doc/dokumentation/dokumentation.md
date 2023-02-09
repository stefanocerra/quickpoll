# Dokumentation Quickpoll

## Testprotokoll

| Testfall                    | Durchführer | Erfolg | Bemerkung                       |
| --------------------------- | ----------- | ------ | ------------------------------- |
| Registrieren                | Sandro      | Ja     | Funktioniert korrekt.           |
| Login                       | Joel        | Nein   | user not found.                 |
| Login                       | Sandro      | Nein   | user not found.                 |
| Login                       | Stefano     | Ja     | Man kann sich einloggen.        |
| Gruppe erstellen            | Joel        | Nein   | no id.                          |
| Gruppe erstellen            | Joel        | Ja     | Hat reibungslos funktioniert.   |
| Umfrage erstellen           | Sandro      | Nein   | Umfrage wird nicht gespeichert. |
| Umfrage erstellen           | Sandro      | Ja     | Funktioniert.                   |
| Umfrage ausfüllen           | Stefano     | Ja     | Hat funktioniert.               |
| Umfrage Ergebnisse anzeigen | Joel        | Ja     | Funktioniert wie erwartet.      |
| QR Code                     | Sandro      | Ja     | Funktioniert.                   |

## Reflexion

### SOLL

Als erstes kommt man auf eine Seite, wo man sich registrieren oder anmelden kann.
Wenn man sich registriert und angemeldet hat, kann man eine Gruppe erstellen und Freunde einladen, oder einer Gruppe beitreten. In dieser Gruppe kann man eine Abstimmung erstellen und ausfüllen. Dabei erhält jeder der in der Gruppe ist eine Push Benachrichtigung und wird dazu aufgefordert die Umfrage auszufüllen. Wenn man die Abstimmung fertig ausgefüllt hat, sieht man direkt das jetzige Resultat der Abstimmung als Kreisdiagramm.

### IST

Man kommt auf eine Seite wo man sich registrieren oder anmelden kann. Wenn man sich registriert und angemeldet hat, kann man eine Gruppe erstellen, mit der man Abstimmungen durchführen kann. Wenn die Gruppe erstellt ist, wird automatisch ein QR code generiert, womit man der Gruppe beitreten kann. Wenn man einer Gruppe beitreten möchte, kann muss man den QR code scannen.
Nach dem Erstellen einer Gruppe, kann man eine Abstimmung erstellen, danach kann man sie ausfüllen und schlussendlich dann auch das Resultat anschauen, das als Kreis Diagramm dargestellt wird.
Da man für das implementieren von Push Benachrichtigungen einen Apple Developer Account benötigt, konnten wir dieses Feature im Moment nicht implementieren.

## Veröffentlichung

Um eine App im Apple App Store veröffentlichen zu können muss man einen **Apple Developer Account** haben und dem **Apple Developer Program** beitreten. Dafür muss man jährlich 109 CHF bezahlen.

Als nächstes brauch man einen **Bundle Identifier** für die App. Dieser dient zur Identifizierung einer App und wird meistens schon direkt beim Erstellen des Projekts erstellt. Das Format ist folgendes:

_tld_._domain_._app_ zum beispiel _com.apple.xcode_

Folgend kann man dann seine App über das **App Store Connect** Portal bei Apple einreichen, worauf diese dann von Apple überprüft wird. Gegebenenfalls müssen im nachhinein noch Anpassungen an der App gemacht werden und kann anschliessend erneut eingereicht werden. Nachdem die App akzeptiert wurde, ist sie dann anschliessend im App Store verfügbar.

## Installationsanleitung

### Vorraussetzungen

- macOS Monterey oder höher
- Xcode >= 13.4.1
- iOS 15.5 Simulator

### Xcode

Xcode kann aus dem AppStore oder [hier](https://developer.apple.com/xcode/) heruntergeladen und installiert werden.

### iOS Simulator

Nach installation von Xcode muss noch der richtige Simulator installiert werden.

Dafür geht man in Xcode in den **Einstellungen** unter **Components**.

![Step 1](img/install%201.png)

Hier installiert man dann die entsprechende Version, in dem Fall **_iOS 15.5 Simulator_**.
![Step 3](img/install%203.png)

Falls die oberste Version _15.4_ ist, dann ist _15.5_ schon installiert.
![Step 2](img/install%202.png)
