# CJP Example Template Library

This repository is an example template library for CloudBees Jenkins Enterprise.

# Example templates

The following examples are included:

* [Freestyle](freestyle/freestyle-github-project.xml.template)
* [Freestyle with Auxilary](freestyle-with-auxilary/album-project.xml.template)
* [Pipeline](pipeline/github-pipeline-project.xml.template)
* [Multi-branch Pipeline](multibranch-pipeline/multibranch-pipeline-github-project.xml.template)
* [GitHub Organization](github-organization/github-organization.xml.template)

# File format and structure

Template repositories can be structured however the user desires. The only
requirement is that template filenames end in `.xml.template`.

Templates in this repository demostrate how to include other files in templates
to make tempalte development easier.

This is done with the include directive:

    <!-- include "file.xml" -->

The include directive is a special comment in the file that tells Jenkins how
to combine files into a single template.


Some parts of a template may require escaping to become valid XML. When this is
necessary we pass the `escape_xml` parameter as well:

    <!-- include "file.xml", escape_xml: true -->


# Template Lifecycle


Directives, like `<-- include "file.xml" -->`, are evaluated while generating the template
`config.xml` (1). However, template variables (`${variable}`) and expressions
(`<%= expression %>`) are evaluated when generating the job `config.xml` (2).

    ┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐
    │                         │  │                         │  │                         │
    │          User           │  │       Repository        │  │         Jenkins         │
    │                         │  │                         │  │                         │
    └─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘
                 │                            │                            │
  
                 │ Add template               │                            │
                  ───────────────────────────▶  New template
                 │                            │───────────────────────────▶░ ────╮ (1) Generate template
                                                                           ░     │ config.xml
                 │                            │                            ░ ◀───╯
  
                 │                            │                            │
  
                 │ Adds new job               │                            │
                  ────────────────────────────────────────────────────────▶░ ────╮ (1) Generate template
                 │                            │                            ░     │ config.xml
                                                                           ░ ◀───╯
                 │                            │                            ░
                                                                           ░ ────╮ (2) Generate job
                 │                            │                            ░     │ config.xml
                                                                           ░ ◀───╯
                 │                            │                            │
                   Update template
                 │───────────────────────────▶│ Updated template           │
                                               ───────────────────────────▶░ ────╮ (1) Regenerate template
                 │                            │                            ░     │ config.xml
                                                                           ░ ◀───╯
                 │                            │                            ░
                                                                           ░ ────╮ (2) Regenerate job
                 │                            │                            ░     │ config.xml
                                                                           ░ ◀───╯
                 │                            │                            │
