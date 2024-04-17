### Microsoft Office Attacks.

#### Attack Presentation.

The client-side attacks based on Microsoft Office's programs is a type of attack that involves the macros feature of Microsoft Office tools in a procedure that leads to RCE on victim's host. This macros are based in VBA.

In this repository we can find some scripts and procedures to craft and test macros that run arbitrary code when this gets open.

<br>

#### How to make a Macro.

The macro is a document which consist in a script built in VBA that get stored along with a Microsoft Office's document and get executed in certains conditions when some user interacts with it.

In order to create a macro from a VBA script we follow the nexts steps:

- Open a Word document.
- Go to View > Macros.
- Set fields 'Macros in' (your document) and 'Macro name'.
- Copy/Paste VBA script.
- Test it pressing [F5] or clicking 'Run' botton.
- If is all correct, save the document as 'Word macro-enabled document'.

For simplicity, the scripts stored in this repository have the extension .vba. This is formally incorrect since the vba scripts are recorded as macros and stored along the document which have his own extension (.doc, .xslx, etc).