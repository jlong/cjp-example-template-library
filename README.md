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

Library Templates are written using the same XML that Jenkins saves CJP
Template configuration to disk. In fact, you can take the `config.xml` for any
CJP Template and use that as the basis for a template in your library without
any modification.

In addition the the standard XML for templates, library templates can also
use directives. The `include` directive allows you to build templates from
several files. This facilitates sharing code between templates.

To include another file in a template, you write:

    <!-- include "file.xml" -->

References to files are relative to the directory of the current file. So to
include a file one directory up (in the parent directory) you write:

    <!-- include "../file.xml" -->

Some parts of a template may require escaping to become valid XML. When this is
necessary we pass the `escape_xml` parameter as well:

    <!-- include "file.xml", escape_xml: true -->

When true, the `escape_xml` parameter will cause all angle brackets(`<`, `>`)
and ampersands (`&`) to be escaped.

# Template lifecycle

Templates are compiled in two stages:

(1) In the first stage, the template definition from the repository is compiled
to produce the template's `config.xml` which is stored in the Jenkins
configuration. In this stage, directives (like `<!-- include "file.xml" -->`)
are evaluated.

(2) In the second stage, the template `config.xml` is evaluated and the instance
job `config.xml` is produced. In this stage, template variables (`${variable}`) and expressions
(`<%= expression %>`) are evaluated.


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
                   Create template instance
                 │────────────────────────────────────────────────────────▶░ ────╮ (2) Generate job
                                                                           ░     │ config.xml
                 │                            │                            ░ ◀───╯

                 │ Update template            │                            │
                  ───────────────────────────▶  Updated template
                 │                            │───────────────────────────▶░ ────╮ (1) Regenerate template
                                                                           ░     │ config.xml
                 │                            │                            ░ ◀───╯
                                                                           ░
                 │                            │                            ░ ────╮ (2) Regenerate job
                                                                           ░     │ config.xml
                 │                            │                            ░ ◀───╯

                 │                            │                            │
