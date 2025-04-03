# April 2, 2025 || 12:27AM.

Okay, I have managed to unify the navigation, and make it work with the session token thing.
However, whenever I register, there is this side effect where it is logged in (not sure if we ARE, but we are being redirected to home.)
I am pretty sure I have removed all references of this. Anyways, time to investigate tomorrow.

Also, I have to work on the search, database (persistence), and the lesson page tomorrow. It's a long day.

# April 3, 2025 || 10:13AM.

I have managed to add some basic information in the lessons page, and when the tiles in the home
menu are clicked, the pages show up. Now, I have to do the following things next time:
- Parse the expression values into a evaluate-able objects
- Replace the `String`-typed units field in the lessons to refer to the complete units as
  specified in the document. It should have the shortcuts, display, name, and stuff.

I should also start on the data persistence side with firebase. Time to search later.