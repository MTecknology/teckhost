/home/tester/fuz:
  file.managed:
    - user: tester
    - group: tester
    - contents: |
        buz
    - require:
      - user: tester
