import { Logger } from '../utils/logger';

export interface DataModelConfig {
    enableCache: boolean;
    cacheSize: number;
    enableLogging: boolean;
    maxRetries: number;
    timeout: number;
}

export class DataModel {
    private config: DataModelConfig;
    private cache: Map<string, any>;
    private logger: Logger;
    private data: any[];
    
    constructor(config: DataModelConfig) {
        this.config = config;
        this.cache = new Map();
        this.logger = new Logger();
        this.data = [];
        
        if (config.enableCache && config.cacheSize > 0) {
            this.cache = new Map();
        }
        
        if (!config.enableLogging) {
            this.logger.setLevel('error');
        }
    }

    addItem(item: any): void {
        this.logger.debug(`Adding item: ${JSON.stringify(item)}`);
        
        this.data.push(item);
        
        if (this.config.enableCache && item.id) {
            this.cache.set(`item_${item.id}`, item);
        }
    }

    getItem(id: number): any {
        const cacheKey = `item_${id}`;
        
        if (this.config.enableCache && this.cache.has(cacheKey)) {
            this.logger.debug(`Cache hit for item ${id}`);
            return this.cache.get(cacheKey);
        }
        
        const item = this.data.find(d => d.id === id);
        
        if (item && this.config.enableCache) {
            this.cache.set(cacheKey, item);
        }
        
        return item;
    }

    updateItem(id: number, updates: any): any {
        const index = this.data.findIndex(d => d.id === id);
        
        if (index === -1) {
            this.logger.warn(`Item ${id} not found for update`);
            return null;
        }
        
        const item = this.data[index];
        const updatedItem = { ...item, ...updates };
        this.data[index] = updatedItem;
        
        if (this.config.enableCache) {
            this.cache.set(`item_${id}`, updatedItem);
        }
        
        this.logger.info(`Item ${id} updated`);
        return updatedItem;
    }

    deleteItem(id: number): boolean {
        const index = this.data.findIndex(d => d.id === id);
        
        if (index === -1) {
            this.logger.warn(`Item ${id} not found for deletion`);
            return false;
        }
        
        this.data.splice(index, 1);
        
        if (this.config.enableCache) {
            this.cache.delete(`item_${id}`);
        }
        
        this.logger.info(`Item ${id} deleted`);
        return true;
    }

    getAllItems(): any[] {
        return this.data;
    }

    filterItems(criteria: any): any[] {
        let result = this.data;
        
        if (criteria.id) {
            result = result.filter(item => item.id === criteria.id);
        }
        
        if (criteria.name) {
            result = result.filter(item => item.name.includes(criteria.name));
        }
        
        if (criteria.category) {
            result = result.filter(item => item.category === criteria.category);
        }
        
        if (criteria.status) {
            result = result.filter(item => item.status === criteria.status);
        }
        
        if (criteria.minValue) {
            result = result.filter(item => item.value >= criteria.minValue);
        }
        
        if (criteria.maxValue) {
            result = result.filter(item => item.value <= criteria.maxValue);
        }
        
        if (criteria.tags && Array.isArray(criteria.tags)) {
            result = result.filter(item => {
                if (!item.tags) return false;
                return criteria.tags.some((tag: string) => item.tags.includes(tag));
            });
        }
        
        if (criteria.createdAfter) {
            const afterDate = new Date(criteria.createdAfter);
            result = result.filter(item => new Date(item.createdAt) >= afterDate);
        }
        
        if (criteria.createdBefore) {
            const beforeDate = new Date(criteria.createdBefore);
            result = result.filter(item => new Date(item.createdAt) <= beforeDate);
        }
        
        if (criteria.sortBy) {
            const sortOrder = criteria.sortOrder === 'desc' ? -1 : 1;
            result = result.sort((a, b) => {
                if (a[criteria.sortBy] < b[criteria.sortBy]) return -1 * sortOrder;
                if (a[criteria.sortBy] > b[criteria.sortBy]) return 1 * sortOrder;
                return 0;
            });
        }
        
        if (criteria.limit) {
            result = result.slice(0, criteria.limit);
        }
        
        if (criteria.offset) {
            result = result.slice(criteria.offset);
        }
        
        return result;
    }

    clearCache(): void {
        if (this.config.enableCache) {
            this.cache.clear();
            this.logger.info('Cache cleared');
        }
    }

    getCacheSize(): number {
        return this.config.enableCache ? this.cache.size : 0;
    }

    processItems(items: any[], operations: any): any[] {
        let result = items;
        
        if (operations.transform) {
            result = result.map(item => {
                const transformed: any = {};
                for (const key of Object.keys(item)) {
                    if (operations.transform[key]) {
                        transformed[key] = operations.transform[key](item[key]);
                    } else {
                        transformed[key] = item[key];
                    }
                }
                return transformed;
            });
        }
        
        if (operations.filter) {
            result = result.filter(item => {
                for (const key of Object.keys(operations.filter)) {
                    if (item[key] !== operations.filter[key]) {
                        return false;
                    }
                }
                return true;
            });
        }
        
        if (operations.aggregate) {
            const aggregated: any = {};
            for (const item of result) {
                for (const field of operations.aggregate.fields) {
                    if (!aggregated[field]) {
                        aggregated[field] = [];
                    }
                    aggregated[field].push(item[field]);
                }
            }
            
            for (const field of operations.aggregate.fields) {
                const values = aggregated[field];
                aggregated[`${field}_sum`] = values.reduce((a: number, b: number) => a + b, 0);
                aggregated[`${field}_avg`] = aggregated[`${field}_sum`] / values.length;
                aggregated[`${field}_min`] = Math.min(...values);
                aggregated[`${field}_max`] = Math.max(...values);
            }
            
            return aggregated;
        }
        
        return result;
    }

    importData(data: any[]): number {
        let imported = 0;
        
        for (const item of data) {
            if (this.validateItem(item)) {
                this.addItem(item);
                imported++;
            }
        }
        
        return imported;
    }

    exportData(): any[] {
        return this.data.map(item => ({ ...item }));
    }

    validateItem(item: any): boolean {
        if (!item) return false;
        if (!item.id) return false;
        if (this.data.some(d => d.id === item.id)) return false;
        return true;
    }

    getStatistics(): any {
        if (this.data.length === 0) {
            return {
                count: 0,
                categories: {},
                statusCounts: {},
                averageValue: 0
            };
        }
        
        const categories: any = {};
        const statusCounts: any = {};
        let totalValue = 0;
        
        for (const item of this.data) {
            if (item.category) {
                categories[item.category] = (categories[item.category] || 0) + 1;
            }
            
            if (item.status) {
                statusCounts[item.status] = (statusCounts[item.status] || 0) + 1;
            }
            
            if (item.value) {
                totalValue += item.value;
            }
        }
        
        return {
            count: this.data.length,
            categories,
            statusCounts,
            averageValue: totalValue / this.data.length
        };
    }
}
