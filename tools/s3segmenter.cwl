#!/usr/bin/env cwl-runner
#
# Author: Allison Creason

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python3", "/app/S3segmenter.py"]

doc: "S3Segmenter"

hints:
  DockerRequirement:
    dockerPull: labsyspharm/s3segmenter:1.3.12

requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement

inputs:
  registered-image:
    type: File
    inputBinding:
      position: 19
      prefix: "--imagePath"

  contoursClassProbPath:
    type: File?
    inputBinding: 
      position: 1
      prefix: "--contoursClassProbPath"
      
  nucleiClassProbPath:
    type: File?
    inputBinding:
      position: 2
      prefix: "--nucleiClassProbPath"

  stackProbPath:
    type: File?
    inputBinding:
      position: 3
      prefix: "--stackProbPath"

  probMapChan:
    type: int
    inputBinding:
      position: 4
      prefix: "--probMapChan"

  crop:
    type: string
    inputBinding:
      position: 5
      prefix: "--crop"

  cytoMethod:
    type: string
    inputBinding:
      position: 6
      prefix: "--cytoMethod"

  nucleiFilter:
    type: string
    inputBinding:
      position: 7
      prefix: "--nucleiFilter"

  nucleiRegion:
    type: string
    inputBinding:
      position: 8
      prefix: "--nucleiRegion"

  segmentCytoplasm:
    type: string
    inputBinding:
      position: 9
      prefix: "--segmentCytoplasm"

  saveMask:
    type: boolean
    inputBinding:
      position: 10
      prefix: "--saveMask"

  saveFig:
    type: boolean
    inputBinding:
      position: 11
      prefix: "--saveFig"

  cytoDilation:
    type: int
    inputBinding:
      position: 12
      prefix: "--cytoDilation"

  logSigma:
    type: string
    inputBinding:
      position: 13
      prefix: "--logSigma"
      shellQuote: false

  CytoMaskChan:
    type: string
    inputBinding:
      position: 14
      prefix: "--CytoMaskChan"

  detectPuncta:
    type: string
    inputBinding:
      position: 15
      prefix: "--detectPuncta"

  punctaSigma:
    type: string
    inputBinding:
      position: 16
      prefix: "--punctaSigma"

  punctaSD:
    type: string
    inputBinding:
      position: 17
      prefix: "--punctaSD"

  outputPath:
    type: string
    inputBinding:
      position: 18
      prefix: "--outputPath"

outputs:
  masks:
    type: File
    outputBinding:
      glob: "$(inputs.outputPath)/*.ome.tif"
  outlines:
    type: File
    outputBinding:
      glob: "$(inputs.outputPath)/qc/*.ome.tif"

