#!/usr/bin/env cwl-runner
#
# Author: Allison Creason

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python","/app/CommandSingleCellExtraction.py"]

doc: "Single cell quantification"

hints:
  DockerRequirement:
    dockerPull: labsyspharm/quantification:1.5.1

requirements:
  - class: InlineJavascriptRequirement

inputs:
  image:
    type: File
    inputBinding:
      position: 4
      prefix: "--image"

  masks:
    type: File
    inputBinding: 
      position: 1
      prefix: "--masks"
      
  output:
    type: string
    inputBinding:
      position: 2
      prefix: "--output"

  channel_names:
    type: File?
    inputBinding:
      position: 3
      prefix: "--channel_names"

outputs:
  quantified:
    type: File
    outputBinding:
      glob: "$(inputs.output)/*.csv"

