export function multiply(a: number, b: number): number {
    return a * b;
}

export function isValid(value: number): boolean {
    return value >= 0 && value <= 100;
}

export function formatMessage(message: string): string {
    return `[INFO] ${message}`;
}