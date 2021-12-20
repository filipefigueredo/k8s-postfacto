**## Overview**

Thank you for your contribution to the **master** branch. The master branch is where official release history is kept. This is the place to go if you're submitting a hotfix or preparing a release. Please consider submitting your PR to the **develop** branch if it's a feature.

- **Note**: The entire master branch codebase will be used in the production environment.

**## PR Checklist**

Please ensure the following before submitting this PR:

- [ ] You complied with our [Pull Request Submission Guidelines](https://nma-spms.visualstudio.com/MySNSAppsServices/_wiki/wikis/MySNSAppsServices.wiki/50/Pull-Request-Submission-Guidelines).
- [ ] The code builds without errors or warnings(hint: `npm run build`).
- [ ] The linting tools were executed without errors or warnings(hint: `npm run lint`).
- [ ] The coverage tests were executed without any errors or warnings(hint: `npm run test:cov`).
- [ ] The repository version was updated in `./package.json` to match the current release version.
- [ ] The changelog was updated in `./CHANGELOG.md` file.
- [ ] The documentation content was updated in `./README.md` file.
- [ ] Whenever possible, the dependencies were updated to the latest compatible versions(hint: `npm outdated` then `npx npm-upgrade`).

**## PR Type**

What kind of change does this PR introduce?

- [ ] Bugfix: (insert here the version to be released. Example: v1.0.1).
- [ ] Release: (insert here the version to be released. Example: v1.1.0).

**### Does this PR introduce a breaking change?**

- [ ] Yes.
- [ ] No.

**### What is the new behavior?**

(Please describe here the new behavior)

**### How to test it**

(Please describe here how to test it)

**### Other information**

(Add here any additional information)
