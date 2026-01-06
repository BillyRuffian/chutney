# Configuring Chutney

Chutney has a default configuration which may or may not suit your needs. It's rules are defined in a simple YAML configuration file that you can customise.

## Configuration file

You can name your configuration file `chutney.yml` or `.chutney.yml`. The first style is preferred because it is not hidden by default in most file systems.

The file can be placed in the root of your project, or in a subdirectory called `/config`.

Chutney will create a default configuration file for you, `chutney.yml`, in your current directory if you run:

```bash
chutney --init
```

It will look something like this, but don't worry, it looks more complicated than it is:

```yaml
AvoidOutlineForSingleExample:
    Enabled: true
AvoidFullStop:
    Enabled: true
AvoidScripting:
    Enabled: true
AvoidSplatStepsInBackground:
    Enabled: true
AvoidSplatStepsInScenarios:
    Enabled: true
AvoidTypographersQuotes:
    Enabled: true
BackgroundDoesMoreThanSetup:
    Enabled: true
BackgroundRequiresMultipleScenarios:
    Enabled: true
BadScenarioName:
    Enabled: true
EmptyFeatureFile:
    Enabled: true
FileNameDiffersFeatureName:
    Enabled: true
GivensAfterBackground:
    Enabled: true
MissingExampleName:
    Enabled: true
MissingExampleTable:
    Enabled: true
MissingFeatureDescription:
    Enabled: true
MissingFeatureName:
    Enabled: true
MissingScenarioName:
    Enabled: true
MissingScenarioOutline:
    Enabled: true
MissingTestAction:
    Enabled: true
MissingVerification:
    Enabled: true
InconsistentQuoting:
    Enabled: true
InvalidFileName:
    Enabled: true
InvalidStepFlow:
    Enabled: true
RequiredTagsStartsWith:
    Enabled: false
SameTagDifferentCase:
    Enabled: true
SameTagForAllScenarios:
    Enabled: true
ScenarioNamesMatch:
    Enabled: false
TagUsedMultipleTimes:
    Enabled: true
TooClumsy:
    Enabled: true
TooManyDifferentTags:
    Enabled: true
    MaxCount: 3
TooManySteps:
    Enabled: true
    MaxCount: 10
TooManyTags:
    Enabled: true
    MaxCount: 3
TooLongStep:
    Enabled: true
    MaxLength: 80
UniqueScenarioNames:
    Enabled: true
UnknownVariable:
    Enabled: true
UnusedVariable:
    Enabled: true
UseBackground:
    Enabled: true
UseOutline:
    Enabled: true
```