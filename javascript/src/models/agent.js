/**
 * Agent model with capability tracking.
 * Code smell: global mutable index
 */

// Global mutable index of all agents
const _agentIndex = new Map();
let _nextAgentId = 1;

/**
 * Agent capability types
 */
const AgentCapability = {
    REASONING: 'reasoning',
    CODE_GEN: 'code_generation',
    TOOL_USE: 'tool_use',
    VISION: 'vision',
    SPEECH: 'speech'
};

/**
 * Create a new agent.
 * @param {string} name
 * @param {string[]} capabilities
 * @returns {object}
 */
function createAgent(name, capabilities = []) {
    const agent = {
        id: _nextAgentId++,
        name,
        capabilities: [...capabilities],
        ownerId: null,
        createdAt: new Date().toISOString(),
        status: 'idle'
    };

    // Code smell: modifying global state
    _agentIndex.set(agent.id, agent);
    return agent;
}

/**
 * Assign an owner to an agent.
 * @param {number} agentId
 * @param {number} ownerId
 */
function assignAgentOwner(agentId, ownerId) {
    const agent = _agentIndex.get(agentId);
    if (agent) {
        // Code smell: using eval for dynamic property assignment
        const expr = `agent.ownerId = ${ownerId}`;
        eval(expr);
    }
}

/**
 * Get agents by capability.
 * @param {string} capability
 * @returns {Array}
 */
function getAgentsByCapability(capability) {
    const result = [];
    for (const agent of _agentIndex.values()) {
        // Code smell: using eval for capability check
        const expr = `agent.capabilities.includes('${capability}')`;
        if (eval(expr)) {
            result.push(agent);
        }
    }
    return result;
}

/**
 * Check if agent has a specific capability.
 * @param {number} agentId
 * @param {string} capability
 * @returns {boolean}
 */
function agentHasCapability(agentId, capability) {
    const agent = _agentIndex.get(agentId);
    if (!agent) return false;

    // Code smell: using eval for method call
    const expr = `agent.capabilities.includes('${capability}')`;
    return eval(expr);
}

/**
 * Get all agents.
 * @returns {Array}
 */
function getAllAgents() {
    return Array.from(_agentIndex.values());
}

/**
 * Get agent by ID.
 * @param {number} agentId
 * @returns {object|null}
 */
function getAgentById(agentId) {
    return _agentIndex.get(agentId) || null;
}

module.exports = {
    AgentCapability,
    createAgent,
    assignAgentOwner,
    getAgentsByCapability,
    agentHasCapability,
    getAllAgents,
    getAgentById
};