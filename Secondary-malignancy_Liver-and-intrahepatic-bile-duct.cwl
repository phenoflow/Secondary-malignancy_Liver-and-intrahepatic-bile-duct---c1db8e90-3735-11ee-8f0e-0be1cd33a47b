cwlVersion: v1.0
steps:
  read-potential-cases-omop:
    run: read-potential-cases-omop.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule1
  secondary-malignancy_liver-and-intrahepatic-bile-duct-neoplasm---primary:
    run: secondary-malignancy_liver-and-intrahepatic-bile-duct-neoplasm---primary.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule2
      potentialCases:
        id: potentialCases
        source: read-potential-cases-omop/output
  secondary-malignancy_liver-and-intrahepatic-bile-duct---primary:
    run: secondary-malignancy_liver-and-intrahepatic-bile-duct---primary.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule3
      potentialCases:
        id: potentialCases
        source: secondary-malignancy_liver-and-intrahepatic-bile-duct-neoplasm---primary/output
  secondary-malignant-neoplasm-liver-intrahepatic-bile-secondary-malignancy_liver-and-intrahepatic-bile-duct-duct---secondary:
    run: secondary-malignant-neoplasm-liver-intrahepatic-bile-secondary-malignancy_liver-and-intrahepatic-bile-duct-duct---secondary.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule4
      potentialCases:
        id: potentialCases
        source: secondary-malignancy_liver-and-intrahepatic-bile-duct---primary/output
  output-cases:
    run: output-cases.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule5
      potentialCases:
        id: potentialCases
        source: secondary-malignant-neoplasm-liver-intrahepatic-bile-secondary-malignancy_liver-and-intrahepatic-bile-duct-duct---secondary/output
class: Workflow
inputs:
  inputModule1:
    id: inputModule1
    doc: Js implementation unit
    type: File
  inputModule2:
    id: inputModule2
    doc: Python implementation unit
    type: File
  inputModule3:
    id: inputModule3
    doc: Python implementation unit
    type: File
  inputModule4:
    id: inputModule4
    doc: Python implementation unit
    type: File
  inputModule5:
    id: inputModule5
    doc: Python implementation unit
    type: File
outputs:
  cases:
    id: cases
    type: File
    outputSource: output-cases/output
    outputBinding:
      glob: '*.csv'
requirements:
  SubworkflowFeatureRequirement: {}
