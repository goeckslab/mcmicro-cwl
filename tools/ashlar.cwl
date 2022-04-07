#!/usr/bin/env cwl-runner
#
# Author: Allison Creason

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["ashlar"]

doc: "ashlar stitching and alignment"

hints:
  DockerRequirement:
    dockerPull: labsyspharm/ashlar:1.14.0

requirements:
  - class: InlineJavascriptRequirement

inputs:
  images:
    type: File
    inputBinding:
      position: 13

  filename-format:
    type: string
    inputBinding: 
      position: 1
      prefix: "--filename-format"
      
  align-channel:
    type: int
    inputBinding:
      position: 2
      prefix: "--align-channel"

  maximum-shift:
    type: int
    inputBinding:
      position: 3
      prefix: "--maximum-shift"

  filter-sigma:
    type: int
    inputBinding:
      position: 4
      prefix: "--filter-sigma"

  tile-size:
    type: int
    inputBinding:
      position: 5
      prefix: "--tile-size"

  ffp:
    type: File
    inputBinding:
      position: 6
      prefix: "--ffp"

  dfp:
    type: File
    inputBinding:
      position: 7
      prefix: "--dfp"

  flip-x:
    type: boolean
    inputBinding:
      position: 8
      prefix: "--flip-x"

  flip-y:
    type: boolean
    inputBinding:
      position: 9
      prefix: "--flip-y"

  flip-mosaic-x:
    type: boolean
    inputBinding:
      position: 10
      prefix: "--flip-mosaic-x"

  flip-mosaic-y:
    type: boolean
    inputBinding:
      position: 11
      prefix: "--flip-mosaic-y"

  pyramid:
    type: boolean
    inputBinding:
      position: 12
      prefix: "--pyramid"

outputs:
  registered:
    type: File
    outputBinding:
      glob: "./*.ome.tif"

