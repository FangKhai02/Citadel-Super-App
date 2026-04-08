"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.faceRoutes = faceRoutes;
const faceVerificationService_1 = require("../services/faceVerificationService");
async function faceRoutes(app) {
    // Face comparison endpoint
    app.post('/compare', async (request, reply) => {
        try {
            const { documentImage, selfieImage } = request.body;
            if (!documentImage || !selfieImage) {
                const errorResponse = {
                    success: false,
                    data: null,
                    error: 'Both documentImage and selfieImage are required',
                };
                return reply.status(400).send(errorResponse);
            }
            const result = await (0, faceVerificationService_1.compareFaces)(documentImage, selfieImage);
            const response = {
                success: true,
                data: {
                    verified: result.verified,
                    score: result.score,
                    degraded: result.degraded,
                    message: result.degraded
                        ? 'Face verification unavailable. Please try again later.'
                        : result.verified
                            ? 'Identity verified successfully. Your face matches the document.'
                            : 'Face did not match the identity document. Please retake your selfie.',
                },
                error: null,
            };
            return reply.send(response);
        }
        catch (err) {
            const errorMessage = err instanceof Error ? err.message : 'Face verification failed';
            const errorResponse = {
                success: false,
                data: {
                    verified: false,
                    score: -1,
                    degraded: true,
                    message: errorMessage,
                },
                error: errorMessage,
            };
            return reply.status(422).send(errorResponse);
        }
    });
    // Health check endpoint
    app.get('/health', async (_, reply) => {
        return reply.send({ status: 'ok', service: 'citadel-facenet' });
    });
}
//# sourceMappingURL=faceController.js.map