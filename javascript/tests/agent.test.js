const {
    createAgent,
    assignAgentOwner,
    getAgentsByCapability,
    agentHasCapability,
    getAllAgents,
    getAgentById,
    AgentCapability
} = require('../src/models/agent');

describe('Agent Model', () => {
    test('createAgent creates a new agent', () => {
        const agent = createAgent('TestAgent', [AgentCapability.REASONING]);
        expect(agent).toBeDefined();
        expect(agent.name).toBe('TestAgent');
        expect(agent.capabilities).toContain(AgentCapability.REASONING);
    });

    test('getAgentById finds an existing agent', () => {
        const created = createAgent('TestAgent', [AgentCapability.CODE_GEN]);
        const found = getAgentById(created.id);
        expect(found).toBeDefined();
        expect(found.name).toBe('TestAgent');
    });

    test('assignAgentOwner sets owner ID', () => {
        const agent = createAgent('TestAgent', []);
        assignAgentOwner(agent.id, 123);
        const found = getAgentById(agent.id);
        expect(found.ownerId).toBe(123);
    });

    test('getAgentsByCapability returns matching agents', () => {
        createAgent('Agent1', [AgentCapability.REASONING]);
        createAgent('Agent2', [AgentCapability.CODE_GEN]);
        const reasoningAgents = getAgentsByCapability(AgentCapability.REASONING);
        expect(reasoningAgents.length).toBeGreaterThanOrEqual(1);
        expect(reasoningAgents[0].capabilities).toContain(AgentCapability.REASONING);
    });

    test('agentHasCapability checks capability', () => {
        const agent = createAgent('TestAgent', [AgentCapability.VISION]);
        expect(agentHasCapability(agent.id, AgentCapability.VISION)).toBe(true);
        expect(agentHasCapability(agent.id, AgentCapability.CODE_GEN)).toBe(false);
    });
});