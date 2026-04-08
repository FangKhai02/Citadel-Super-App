import Fastify from 'fastify';
import cors from '@fastify/cors';
import helmet from '@fastify/helmet';
import rateLimit from '@fastify/rate-limit';
import { faceRoutes } from './controllers/faceController';

const PORT = parseInt(process.env.PORT || '3001', 10);
const HOST = process.env.HOST || '0.0.0.0';

async function buildApp() {
  const app = Fastify({
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
  await app.register(cors, {
    origin: true,
    credentials: true,
  });

  await app.register(helmet, {
    contentSecurityPolicy: false,
  });

  // Rate limiting
  await app.register(rateLimit, {
    max: 100,
    timeWindow: '1 minute',
  });

  // Register routes
  await app.register(faceRoutes, { prefix: '/api/face' });

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
  } catch (err) {
    console.error('[Citadel FaceNet] Failed to start server:', err);
    process.exit(1);
  }
}

start();
