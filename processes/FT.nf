process FT {
  input:
  path 'spectrums.mgf'
  script:
  """
  #!/usr/bin/env bash

  sed -i 's/MS_LEVEL/MSLEVEL/g; s/PRECURSOR_MZ/PEPMASS/g' spectrums.mgf

  sirius -i spectrums.mgf -o workspace formula

  sirius --input workspace ftree-export --json --output treespace

  cd treespace

  cp * ${params.result}
  """
}