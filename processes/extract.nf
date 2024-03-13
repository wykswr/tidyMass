process extract {
    input:
    path 'original.mgf'
    output:
    path 'clean.mgf'
    script:
    """
    #!/usr/bin/env python

    from matchms.importing import load_from_mgf
    from matchms.exporting import save_as_mgf
    import matchms.filtering as filtering
    from rdkit import Chem
    from rdkit.Chem.rdMolDescriptors import CalcMolFormula

    keep_attributes = set(["precursor_mz", "charge", "ms_level", "formula", "adduct", "tag"])
    specs = load_from_mgf("original.mgf")

    processed_specs = []

    for idx, spec in enumerate(specs):
        spec = filtering.default_filters(spec)
        spec = filtering.reduce_to_number_of_peaks(spec, 1, 128)
        if not spec:
            continue
        spec.set("ms_level", 2)
        spec.set("tag", idx)
        if spec.get('formula') is None and spec.get('smiles') is not None:
            mol = Chem.MolFromSmiles(spec.get('smiles'))
            if mol is not None:
                spec.set('formula', CalcMolFormula(mol))
        metadata = {key: value for key, value in spec.metadata_dict().items() if key in keep_attributes}
        spec.metadata = metadata
        processed_specs.append(spec)
    
    save_as_mgf(processed_specs, "clean.mgf")
    """
}