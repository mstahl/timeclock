# timeclock

Use timeclock to keep track of your hours working on different things.

## Usage

    clock [options] (command) [project name]

To start working on a project,

    clock in

This will create a `.timesheet` file in the current directory if it doesn't
already exist. This file is a YAML file containing all the hours worked on that
project. (You may wish to add '.timesheet' to your `.gitignore` file.) If a
project name is specified, the hours you log will be added specifically to that
project. You can have as many "projects" living in one directory as you want
(think of these as tasks you're working on). To finish for the day,

    clock out

This will log the time between when you clocked in and now in the YAML file, and
save it as a timesheet entry. For detailed usage information, run `clock` with
no arguments.

To see your timesheet output to the terminal,

    timesheet

## Command-Line Options

For `clock` and `timesheet`:

  -t [timesheet]  : Use the filename as a timesheet

## TODO

This is my to-do list of features I want to write in Timeclock. It is not meant
to be exhaustive.

  * Support for multiple timesheet formatters: HTML, PDF, Excel, etc.
  * API integration with Google Drive, Harvest, etc.
  * Tons more options for `timesheet` command
  * User-level configuration via .timeclock file in home directory

## Contributing to timeclock

  * Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet
  * Check out the issue tracker to make sure someone already hasn't requested
    it and/or contributed it
  * Fork the project
  * Start a feature/bugfix branch
  * Commit and push until you are happy with your contribution
  * Make sure to add tests for it. This is important so I don't break it in a
    future version unintentionally.
  * Please try not to mess with the Rakefile, version, or history. If you want
    to have your own version, or is otherwise necessary, that is fine, but
    please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 max thom stahl. See LICENSE.txt for
further details.
