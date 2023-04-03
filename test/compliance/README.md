CIS Tests
=========

All ``test_cis_*.py`` files were written from scratch while reviewing the
document: ``CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf``. Where
ambiguous, Center for Internet Security (CIS) are the likely copyright holders.
Test logic borrows from standard practices and is likely trivial/public-domain.

This collection of tests does not implement a test for every CIS Recommendation,
nor does it check each item exactly as described in the PDF. Instead, all tests
are implemented in a way that is easy to maintain and audit for this particual
project. It is written in a way that is intended to be easy for others to copy
and adapt to their needs.

These tests are written to be run as a non-root user with sudo access. Usage of
sudo (and provided password) can be configured in ``conftest.py``.
