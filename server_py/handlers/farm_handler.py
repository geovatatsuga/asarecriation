from typing import Dict

from .base_handler import BaseHandler
from protocol.packet_builder import PacketBuilder
from protocol.packet_reader import PacketReader


class FarmHandler(BaseHandler):
    FARM_HARVEST_COLLECT_TEST_REQUEST = 1828
    FARM_HARVEST_COLLECT_TEST_ANSWER = 1829

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            cls.FARM_HARVEST_COLLECT_TEST_REQUEST: "handle_harvest_collect_test",
        }

    def handle_harvest_collect_test(self, reader: PacketReader):
        harvest_id = reader.read_string()

        builder = PacketBuilder()
        builder.write_string(harvest_id)
        builder.write_bool(True)   # canCollect
        builder.write_bool(False)  # hasNoProduct
        builder.write_short(0)     # collectTimes
        builder.write_int(0)       # cdTimeLeftInSec
        self.send_packet(builder.build(self.FARM_HARVEST_COLLECT_TEST_ANSWER))

        collected = self._progress_collect_task()
        suffix = f", collect={collected}" if collected else ""
        self.log(f"FarmHarvestCollectTest: harvestId={harvest_id}{suffix}")

    def _progress_collect_task(self) -> str:
        try:
            from handlers.task_handler import TaskHandler
            handler = TaskHandler(self.session)
            return handler._try_progress_collect_task()
        except Exception as exc:
            self.log(f"Falha ao progredir missao de coleta por harvest: {exc}")
            return ""
