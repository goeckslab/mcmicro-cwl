#!/usr/bin/env cwl-runner
#
# Author: Allison Creason

cwlVersion: v1.0
class: CommandLineTool
baseCommand: []


doc: "Basic illumination and shading correction"

hints:
  DockerRequirement:
    dockerPull: labsyspharm/basic-illumination:1.0.3

requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement

inputs:
  input_image:
    type: File

outputs:
  dfp:
    type: File
    outputBinding:
      glob: "output-dfp.tif"
  ffp: 
    type: File
    outputBinding:
      glob: "output-ffp.tif"


arguments:
  - valueFrom: ImageJ-linux64 --ij2 --headless --run /opt/fiji/imagej_basic_ashlar.py "filename='$(inputs.input_image.path)',output_dir='.',experiment_name='output'"
    shellQuote: false

