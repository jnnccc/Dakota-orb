SET(LIB_REQUIRED_DEP_PACKAGES Teuchos Sacado Phalanx Intrepid  Thyra Tpetra Epetra EpetraExt)
SET(LIB_OPTIONAL_DEP_PACKAGES Stokhos)
SET(TEST_REQUIRED_DEP_PACKAGES)
SET(TEST_OPTIONAL_DEP_PACKAGES Stratimikos)
SET(LIB_REQUIRED_DEP_TPLS MPI Boost)
SET(LIB_OPTIONAL_DEP_TPLS)
SET(TEST_REQUIRED_DEP_TPLS)
SET(TEST_OPTIONAL_DEP_TPLS)

TRIBITS_ALLOW_MISSING_EXTERNAL_PACKAGES(MueLu)
