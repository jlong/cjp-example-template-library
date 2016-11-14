# CJP Example Template Library

This repository is an example template library for CloudBees Jenkins Enterprise.


# Example templates

The following examples are included:

* [Freestyle](freestyle/freestyle-github-project.xml.template)
* [Freestyle with Auxilary](freestyle-with-auxilary/album-project.xml.template)
* [Pipeline](pipeline/github-pipeline-project.xml.template)
* [Multi-branch Pipeline](multibranch-pipeline/multibranch-pipeline-github-project.xml.template)
* [GitHub Organization](github-organization/github-organization.xml.template)


# File structure

Template repositories can be structured however the user desires. The only
requirement is that template filenames end in `.xml.template`.

Templates in this repository demostrate how to include other files in templates
to make tempalte development easier.

This is done with the include directive:

	<%= include "file.xml" %>

Some parts of a template may require escaping to become valid XML. When this is
necessary we pass the `escape_xml` parameter as well:

	<%= include "file.xml", escape_xml: true %>


# Template lifecycle


	┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐
	│                         │  │                         │  │                         │
	│          User           │  │       Repository        │  │         Jenkins         │
	│                         │  │                         │  │                         │
	└─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘
							 │                            │                            │

							 │ Add template               │                            │
								───────────────────────────▶  New template
							 │                            │───────────────────────────▶░ ────╮ Generate template
																																				 ░     │ config.xml
							 │                            │                            ░ ◀───╯

							 │                            │                            │

							 │ Adds new job               │                            │
								────────────────────────────────────────────────────────▶░ ────╮ Generate template
							 │                            │                            ░     │ config.xml
																																				 ░ ◀───╯
							 │                            │                            ░
																																				 ░ ────╮ Generate job
							 │                            │                            ░     │ config.xml
																																				 ░ ◀───╯
							 │                            │                            │
								 Update template
							 │───────────────────────────▶│ Updated template           │
																						 ───────────────────────────▶░ ────╮ Regenerate template
							 │                            │                            ░     │ config.xml
																																				 ░ ◀───╯
							 │                            │                            ░
																																				 ░ ────╮ Regenerate job
							 │                            │                            ░     │ config.xml
																																				 ░ ◀───╯
							 │                            │                            │
