# GitHub Copilot README Template Instructions

## Standard Header Template
Every README.md file must start with this exact template:

```markdown
![](./resources/logos.png)


[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)
### **<kbd>CTRL</kbd> + click to open in new window**

---

```

## Navigation Requirements
At the button of the template, add navigation links to previous/next files in the same directory:

### Rules for Navigation:
1. **File Detection**: Analyze all files in the current directory
2. **Sorting**: Sort files alphabetically using ASCII order (case-sensitive)
3. **Exclusions**: Skip the current README.md file when determining previous/next
4. **Format**: Use this exact format for navigation links:
   ```markdown
   ## Navigation
   [← Previous: filename.ext](./filename.ext) | [Next: filename.ext →](./filename.ext)
   ```


## Complete README Structure Template

```markdown
![](./resources/lab.jpg)
[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)
### **<kbd>CTRL</kbd> + click to open in new window**

# Project Title

## Description
[Brief description of the project/lab]

## Prerequisites
[List any prerequisites or requirements]

## Installation
[Installation steps]

## Usage
[Usage instructions and examples]

## Lab Exercises
[If applicable, list lab exercises or steps]

## Navigation
[← Previous: filename.ext](./filename.ext) | [Next: filename.ext →](./filename.ext)


```

## Special Instructions for Copilot

### When generating README files:
1. **Always start** with the exact header template (image + Cloud Shell button + instruction)
2. **Always include** navigation links based on current directory file analysis
3. **Maintain consistency** in formatting and structure across all README files
4. **Use relative paths** for all local file references
5. **Preserve the exact markdown formatting** including spacing and special characters

### File Analysis Guidelines:
- Consider all file types when creating navigation (`.md`, `.py`, `.js`, `.json`, `.txt`, etc.)
- Use case-sensitive ASCII sorting
- Handle special characters and numbers correctly in filenames
- Skip hidden files (starting with `.`) unless specifically requested

### Cloud Shell Integration:
- The Cloud Shell button should always point to: `https://github.com/nirgeier/DockerComposeLabs`
- The lab.jpg image should always be referenced as: `./resources/lab.jpg`
- Keep the CTRL+click instruction exactly as formatted with `<kbd>` tags

## Quality Checklist
Before completing README generation, ensure:
- [ ] Header template is exactly as specified
- [ ] Navigation links are present and correctly formatted
- [ ] Previous/next files are accurately identified from directory
- [ ] All relative paths use `./` prefix
- [ ] Markdown formatting is consistent
- [ ] No duplicate or missing sections