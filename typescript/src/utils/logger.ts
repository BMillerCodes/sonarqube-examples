export type LogLevel = 'debug' | 'info' | 'warn' | 'error';

export interface LogEntry {
    timestamp: Date;
    level: LogLevel;
    message: string;
    context?: any;
}

export class Logger {
    private logs: LogEntry[] = [];
    private maxLogs: number = 1000;
    private currentLevel: LogLevel = 'info';

    constructor(level?: LogLevel) {
        if (level) {
            this.currentLevel = level;
        }
    }

    setLevel(level: LogLevel): void {
        this.currentLevel = level;
    }

    debug(message: string, context?: any): void {
        this.log('debug', message, context);
    }

    info(message: string, context?: any): void {
        this.log('info', message, context);
    }

    warn(message: string, context?: any): void {
        this.log('warn', message, context);
    }

    error(message: string, context?: any): void {
        this.log('error', message, context);
    }

    private log(level: LogLevel, message: string, context?: any): void {
        const entry: LogEntry = {
            timestamp: new Date(),
            level,
            message,
            context
        };
        
        this.logs.push(entry);
        
        if (this.logs.length > this.maxLogs) {
            this.logs.shift();
        }
        
        const formatted = this.formatLog(entry);
        console.log(formatted);
    }

    private formatLog(entry: LogEntry): string {
        const timestamp = entry.timestamp.toISOString();
        const level = entry.level.toUpperCase().padEnd(5);
        let result = `[${timestamp}] ${level} ${entry.message}`;
        
        if (entry.context) {
            result += ` ${JSON.stringify(entry.context)}`;
        }
        
        return result;
    }

    getLogs(level?: LogLevel): LogEntry[] {
        if (level) {
            return this.logs.filter(log => log.level === level);
        }
        return this.logs;
    }

    clearLogs(): void {
        this.logs = [];
    }

    exportLogs(): string {
        return JSON.stringify(this.logs, null, 2);
    }

    getLogsByContext(contextKey: string, contextValue: any): LogEntry[] {
        return this.logs.filter(log => {
            if (!log.context) return false;
            return log.context[contextKey] === contextValue;
        });
    }

    getLogsByTimeRange(start: Date, end: Date): LogEntry[] {
        return this.logs.filter(log => {
            return log.timestamp >= start && log.timestamp <= end;
        });
    }

    getErrorLogs(): LogEntry[] {
        return this.logs.filter(log => log.level === 'error');
    }

    getWarningLogs(): LogEntry[] {
        return this.logs.filter(log => log.level === 'warn');
    }
}

export const logger = new Logger();
