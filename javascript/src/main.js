const fs = require('fs');
const path = require('path');

function add(a, b) {
    return a + b;
}

function divide(a, b) {
    if (b === 0) {
        throw new Error('Division by zero');
    }
    return a / b;
}

async function main() {
    console.log('Hello from JavaScript SonarQube example!');

    const result = add(5, 3);
    console.log(`5 + 3 = ${result}`);

    try {
        const data = fs.readFileSync(path.join(__dirname, 'nonexistent.txt'), 'utf8');
        console.log(data);
    } catch (err) {
        console.error(`Error: ${err.message}`);
    }
}

main();