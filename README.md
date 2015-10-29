# wait-for-log-message

As a test engineer, I sometimes find myself needing to write automation in bash that has to wait for the appearance of a given log file message before proceeding.

I found an initial solution that technically worked, but it had the side-effect of leaving behind a tail -f process, which would cause the parent script to never really exit (even after finishing and returning control to the console).

The wait-for-log-message.sh script has a function that implements a solution with a named pipe that does not have this side effect.
