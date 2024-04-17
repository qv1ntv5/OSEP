### Microsoft Office Attacks.

#### Attack Presentation.

The client-side attacks based on Microsoft Office is one type of attacke that involves the macros Microsoft Office tools feature to in a procedure that leads to RCE on victim's host. The language the macros of Microsoft Office are based of is VBA.

In this repository we can find some scripts and procedures to craft and test macros that run arbitrary code when gets open.



#### How to make a Macro.

The macro is a document which consist in a script built in VBA that get stored along with the document and get executed in certains conditions when some user interacts with it.

In order to create a macro from a VBA script we follow the nexts steps:

- Open a Word document.
- Go to View > Macros.
- Set fields 'Macros in' (your document) and 'Macro name'.
- Copy/Paste script.
- Test it pressing [F5] or Run botton.
- If is all correct, save the document.

