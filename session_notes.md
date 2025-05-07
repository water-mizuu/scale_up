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

# April 17, 2025 || 3:45PM.

It's been two weeks. I have started work again on the project, and have linked the home page tiles
to the backend. There is basic persistence, but I have to work on the proper learning material later.
I have decided to split the quiz materials into two: "Learn" and "Practice".
- Learn should focus on the conversion themselves.
  - All direct units involved should be asked directly.
  - All indirect units should be quizzed to the users.

# April 22, 2025 || 7:19PM.
Before going to dinner, I have some ideas.
Instead of doing drag and drop, just click. LocalHeros should do the trick in animating.

# April 23, 2025 || 1:10AM.
LocalHeros didn't do anything right. That's stupid.

# April 23, 2025 || 2:20AM.
I have finished the main functionality of the application. All of the thought of quiz are
working as needed. Now, I have to focus on lesson content & other windows. I am thinking of
adding the global prompt based on the "Congrats" / "Oops" messages. This will be useful for
user confirmation and whatnot.

# April 23, 2025 || 9:42AM.
I have to do the following things:
  1. Integrate the sound I requested a while ago.
  2. Design a learn page


# May 2, 2025 || 10:22AM.
I have started to use some *ehem* tools for assisting with design. These are really good.
However, there are still some things I need to do.
  1. Implement the plain "continue" things in learn.
    - These are the questions which just describe the conversion and stuff.
    As such, there are things I need to do:
      1. Create a template for each (direct and direct)
      2. Create variations
      3. Designate the constrained shuffling.
  2. Indicate to the user the locked and stuff.

# May 7, 2025 || 2:25PM.
After some bugfixing, the application is close to completion. I have given up on parametrized conversions as it is outside the scope of the project.