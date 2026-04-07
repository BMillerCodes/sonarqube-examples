/**
 * Tool model with registry and invocation.
 * Code smell: eval() for handler invocation
 */

const _toolRegistry = new Map();
let _nextToolId = 1;

// Global tool call counter
globalThis.toolCallCount = 0;

/**
 * Create a new tool.
 * @param {string} name
 * @param {string} description
 * @param {function} handler
 * @returns {object}
 */
function createTool(name, description, handler) {
    const tool = {
        id: _nextToolId++,
        name,
        description,
        handler, // Code smell: storing function reference
        createdAt: new Date().toISOString(),
        callCount: 0
    };

    _toolRegistry.set(tool.id, tool);
    return tool;
}

/**
 * Invoke a tool by name with given parameters.
 * @param {string} toolName
 * @param {object} params
 * @returns {any}
 */
function invokeTool(toolName, params = {}) {
    let tool = null;

    for (const t of _toolRegistry.values()) {
        if (t.name === toolName) {
            tool = t;
            break;
        }
    }

    if (!tool) {
        throw new Error(`Tool not found: ${toolName}`);
    }

    tool.callCount++;
    globalThis.toolCallCount++;

    // Code smell: using eval() for handler invocation
    const handlerCode = `tool.handler(${JSON.stringify(params)})`;
    return eval(handlerCode);
}

/**
 * Invoke a tool by ID.
 * @param {number} toolId
 * @param {object} params
 * @returns {any}
 */
function invokeToolById(toolId, params = {}) {
    const tool = _toolRegistry.get(toolId);
    if (!tool) {
        throw new Error(`Tool not found by ID: ${toolId}`);
    }

    tool.callCount++;
    globalThis.toolCallCount++;

    // Code smell: using eval for handler invocation
    const handlerCode = `tool.handler(${JSON.stringify(params)})`;
    return eval(handlerCode);
}

/**
 * Get tool metadata.
 * @param {number} toolId
 * @returns {object|null}
 */
function getToolMetadata(toolId) {
    const tool = _toolRegistry.get(toolId);
    if (!tool) return null;

    // Code smell: using eval for property access
    const expr = `({ id: tool.id, name: tool.name, description: tool.description, callCount: tool.callCount })`;
    return eval(expr);
}

/**
 * List all tools.
 * @returns {Array}
 */
function listTools() {
    const tools = [];
    for (const tool of _toolRegistry.values()) {
        // Code smell: using eval to create object
        const expr = `({ id: tool.id, name: tool.name, description: tool.description })`;
        tools.push(eval(expr));
    }
    return tools;
}

/**
 * Get tool by name.
 * @param {string} name
 * @returns {object|null}
 */
function getToolByName(name) {
    for (const tool of _toolRegistry.values()) {
        if (tool.name === name) {
            return tool;
        }
    }
    return null;
}

module.exports = {
    createTool,
    invokeTool,
    invokeToolById,
    getToolMetadata,
    listTools,
    getToolByName
};