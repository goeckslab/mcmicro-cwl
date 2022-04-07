#!/usr/bin/env cwl-runner
#
# Author: Allison Creason

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python", "/app/unmicstWrapper.py"]

doc: "UnMICST - Universal Models for Identifying Cells and Segmenting Tissue"

hints:
  DockerRequirement:
    dockerPull: labsyspharm/unmicst:2.7.1

requirements:
  - class: InlineJavascriptRequirement

inputs:
  registered-image:
    type: File
    inputBinding:
      position: 10

  tool:
    type: string
    inputBinding: 
      position: 1
      prefix: "--tool"
      
  outputPath:
    type: string
    inputBinding:
      position: 2
      prefix: "--outputPath"

  channel:
    type: int
    inputBinding:
      position: 3
      prefix: "--channel"

  model:
    type: string
    inputBinding:
      position: 4
      prefix: "--model"

  mean:
    type: float
    inputBinding:
      position: 5
      prefix: "--mean"

  std:
    type: float
    inputBinding:
      position: 6
      prefix: "--std"

  scalingFactor:
    type: float
    inputBinding:
      position: 7
      prefix: "--scalingFactor"

  stackOutput:
    type: boolean
    inputBinding:
      position: 8
      prefix: "--stackOutput"

  outlier:
    type: float
    inputBinding:
      position: 9
      prefix: "--outlier"

outputs:
  probabilities:
    type: File
    outputBinding:
      glob: "$(inputs.outputPath)/*.tif"
  preview:
    type: File
    outputBinding:
      glob: "$(inputs.outputPath)/qc/*.tif"

