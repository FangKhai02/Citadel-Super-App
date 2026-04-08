"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fastify_1 = __importDefault(require("fastify"));
const cors_1 = __importDefault(require("@fastify/cors"));
const helmet_1 = __importDefault(require("@fastify/helmet"));
const rate_limit_1 = __importDefault(require("@fastify/rate-limit"));
const faceController_1 = require("./controllers/faceController");
const PORT = parseInt(process.env.PORT || '3001', 10);
const HOST = process.env.HOST || '0.0.0.0';
async function buildApp() {
    const app = (0, fastify_1.default)({
        logger: {
            level: 'info',
            transport: {
                target: 'pino-pretty',
                options: {
                    translateTime: 'HH:MM:ss Z',
                    ignore: 'pid,hostname',
                },
            },
        },
        bodyLimit: 50 * 1024 * 1024, // 50MB to accommodate base64 images
    });
    // Security plugins
    await app.register(cors_1.default, {
        origin: true,
        credentials: true,
    });
    await app.register(helmet_1.default, {
        contentSecurityPolicy: false,
    });
    // Rate limiting
    await app.register(rate_limit_1.default, {
        max: 100,
        timeWindow: '1 minute',
    });
    // Register routes
    await app.register(faceController_1.faceRoutes, { prefix: '/api/face' });
    // Root health check
    app.get('/health', async (_, reply) => {
        return reply.send({ status: 'ok', service: 'citadel-facenet', timestamp: new Date().toISOString() });
    });
    return app;
}
async function start() {
    try {
        const app = await buildApp();
        await app.listen({ port: PORT, host: HOST });
        console.log(`[Citadel FaceNet] Server running on http://${HOST}:${PORT}`);
        console.log(`[Citadel FaceNet] Face comparison endpoint: POST /api/face/compare`);
    }
    catch (err) {
        console.error('[Citadel FaceNet] Failed to start server:', err);
        process.exit(1);
    }
}
start();
//# sourceMappingURL=index.js.map