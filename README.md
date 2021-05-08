# GUSTO

## Description

The **Grading Utility for System Biology Teaching Operation** (**GUSTO**) is a
semiautomatic Python script to grade student submitted MATLAB scripts.

### Prerequisites

1. Set up MATLAB in VSCode using the [MATLAB extension pack](https://marketplace.visualstudio.com/items?itemName=bat67.matlab-extension-pack).
2. Have some way to sum the scores. The accompanied R script `gras.R` can be
   used. This function may be integrated into gusto in the future.

### Grading workflow

1. Download the Snappy archive from GauchoSpace and extract it.
2. Use `gusto.py` to generate a CSV file. Use `-r` parameter to include the
    score of each rubric item.
3. Open the CSV file in your favorite spreadsheet program.
4. Set up necessary variables in the MATLAB console.
5. Grade in a loop
    1. Inspect script
    2. Execute script
    3. Log scores
6. Sum score and upload to GauchoSpace.

## Author

* [Yishen Miao](https://github.com/mys721tx)

## License

[GNU General Public License, version 3](http://www.gnu.org/licenses/gpl-3.0.html)
