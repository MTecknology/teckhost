/home/testuser/fuz:
  file.managed:
    - user: testuser
    - group: testuser
    - contents: |
        buz
    - require:
      - user: testuser
