import * as fs from 'fs';
import * as path from 'path';

interface Result {
    value: number;
    label: string;
}

function add(a: number, b: number): number {
    return a + b;
}

function divide(a: number, b: number): number {
    if (b === 0) {
        throw new Error('Division by zero');
    }
    return a / b;
}

async function main(): Promise<void> {
    console.log('Hello from TypeScript SonarQube example!');

    const result: number = add(5, 3);
    console.log(`5 + 3 = ${result}`);

    try {
        const data = fs.readFileSync(path.join(__dirname, 'nonexistent.txt'), 'utf8');
        console.log(data);
    } catch (err: unknown) {
        const message = err instanceof Error ? err.message : String(err);
        console.error(`Error: ${message}`);
    }
}

main();