#!/usr/bin/env cwl-runner
#
# Author: Allison Creason

class: Workflow
cwlVersion: v1.0

doc: "MCMicro Multiplex Tissue Imaging Pipeline"

requirements:
  - class: MultipleInputFeatureRequirement

inputs:
  IMAGES: File

outputs:
  OUTPUT:
      type:
        type: array
        items: File
      linkMerge: merge_flattened
      outputSource: [basic-illumination/dfp, basic-illumination/ffp, ashlar/registered, unmicst/probabilities, unmicst/preview, s3segmenter/masks, s3segmenter/outlines, mcquant/quantified]

steps:

  basic-illumination:
    run: ../tools/basic-illumination.cwl
    in: 
      input_image: IMAGES
    out: [dfp, ffp]

  ashlar:
    run: ../tools/ashlar.cwl
    in:
      images: IMAGES
      dfp: basic-illumination/dfp
      ffp: basic-illumination/ffp
      filename-format: {default: "registered.ome.tif"}
      align-channel: { default: 1 }
      maximum-shift: { default: 30 }
      filter-sigma: { default: 0 }
      pyramid: { default: true }
      tile-size: { default: 1024 }
      flip-x: { default: false }
      flip-y: { default: false }
      flip-mosaic-x: { default: false }
      flip-mosaic-y: { default: false }
    out: [registered]

  unmicst:
    run: ../tools/unmicst.cwl
    in: 
      registered-image: ashlar/registered
      tool: { default: "unmicst-legacy" }
      outputPath: { default: "." }
      channel: { default: 1 }
      model: { default: "nucleiDAPI" }
      mean: { default: -1.0 }
      std: { default: -1.0 }
      scalingFactor: { default: 1.0 }
      stackOutput: { default: true }
      outlier: { default: -1.0 }
    out: [probabilities, preview]

  s3segmenter:
    run: ../tools/s3segmenter.cwl
    in:
      registered-image: ashlar/registered
      stackProbPath: unmicst/probabilities
      probMapChan: { default: 1 }
      crop: { default: "noCrop" }
      cytoMethod: { default: "distanceTransform" }
      nucleiFilter: { default: "IntPM" }
      nucleiRegion: { default: "watershedContourInt" }
      segmentCytoplasm: { default: "ignoreCytoplasm" }
      saveMask: { default: true }
      saveFig: { default: true }
      cytoDilation: { default: 5 }
      logSigma: { default: "3 60" }
      CytoMaskChan: { default: "2" }
      detectPuncta: { default: "-1" }
      punctaSigma: { default: "1" }
      punctaSD: { default: "4" }
      outputPath: { default: "." }
    out: [masks, outlines]

  mcquant:
    run: ../tools/mc-quant.cwl
    in:
      image: ashlar/registered
      masks: s3segmenter/masks
      output: { default: "." }
    out: [quantified]

