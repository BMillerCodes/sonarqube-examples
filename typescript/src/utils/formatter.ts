export class Formatter {
    static currency(amount: number, currency: string = 'USD'): string {
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency
        }).format(amount);
    }

    static percentage(value: number, decimals: number = 2): string {
        return (value * 100).toFixed(decimals) + '%';
    }

    static date(date: Date, format: string = 'YYYY-MM-DD'): string {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        
        return format
            .replace('YYYY', String(year))
            .replace('MM', month)
            .replace('DD', day);
    }

    static time(date: Date, format: string = 'HH:mm:ss'): string {
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const seconds = String(date.getSeconds()).padStart(2, '0');
        
        return format
            .replace('HH', hours)
            .replace('mm', minutes)
            .replace('ss', seconds);
    }

    static datetime(date: Date): string {
        return `${this.date(date)} ${this.time(date)}`;
    }

    static capitalize(str: string): string {
        if (!str) return '';
        return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase();
    }

    static titleCase(str: string): string {
        if (!str) return '';
        return str.split(' ')
            .map(word => this.capitalize(word))
            .join(' ');
    }

    static snakeCase(str: string): string {
        if (!str) return '';
        return str
            .replace(/([a-z])([A-Z])/g, '$1_$2')
            .replace(/\s+/g, '_')
            .toLowerCase();
    }

    static camelCase(str: string): string {
        if (!str) return '';
        return str
            .replace(/[-_\s]+(.)?/g, (_, char) => char ? char.toUpperCase() : '')
            .replace(/^(.)/, (_, char) => char.toLowerCase());
    }

    static kebabCase(str: string): string {
        if (!str) return '';
        return str
            .replace(/([a-z])([A-Z])/g, '$1-$2')
            .replace(/\s+/g, '-')
            .toLowerCase();
    }

    static truncate(str: string, maxLength: number, suffix: string = '...'): string {
        if (!str || str.length <= maxLength) return str;
        return str.substring(0, maxLength - suffix.length) + suffix;
    }

    static pad(str: string, length: number, char: string = ' ', direction: 'left' | 'right' = 'left'): string {
        if (!str) str = '';
        const padLength = length - str.length;
        if (padLength <= 0) return str;
        
        const padding = char.repeat(padLength);
        return direction === 'left' ? padding + str : str + padding;
    }

    static mask(str: string, start: number = 4, end: number = 4, maskChar: string = '*'): string {
        if (!str || str.length <= start + end) return str;
        
        const startPart = str.substring(0, start);
        const endPart = str.substring(str.length - end);
        const maskedPart = maskChar.repeat(str.length - start - end);
        
        return startPart + maskedPart + endPart;
    }

    static pluralize(count: number, singular: string, plural?: string): string {
        if (count === 1) return `${count} ${singular}`;
        return `${count} ${plural || singular + 's'}`;
    }

    static bytesToSize(bytes: number): string {
        if (bytes === 0) return '0 Bytes';
        
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    static number(value: number, decimals: number = 0): string {
        return value.toFixed(decimals).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }

    static hexToRgb(hex: string): { r: number; g: number; b: number } | null {
        const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
        return result ? {
            r: parseInt(result[1], 16),
            g: parseInt(result[2], 16),
            b: parseInt(result[3], 16)
        } : null;
    }

    static slugify(str: string): string {
        return str
            .toLowerCase()
            .trim()
            .replace(/[^\w\s-]/g, '')
            .replace(/[\s_-]+/g, '-')
            .replace(/^-+|-+$/g, '');
    }
}
